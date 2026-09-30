mock_provider "aws" {}

run "disabled_module" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = length(aws_kms_key.default) == 0 && length(aws_kms_alias.default) == 0
    error_message = "A disabled module must not create a key or primary alias."
  }
}

run "standard_key_features" {
  command = plan

  variables {
    name         = "test"
    region       = "us-west-2"
    create_alias = false
    aliases      = ["alias/test-secondary"]
    grants = {
      application = {
        grantee_principal         = "arn:aws:iam::111122223333:role/application"
        operations                = ["Encrypt", "Decrypt"]
        encryption_context_equals = { Environment = "test" }
      }
    }
  }

  assert {
    condition     = length(aws_kms_key.default) == 1 && aws_kms_key.default[0].region == "us-west-2"
    error_message = "The standard key must be created in the requested Region."
  }

  assert {
    condition     = length(aws_kms_alias.default) == 0 && length(aws_kms_alias.additional) == 1
    error_message = "The primary alias must be optional without disabling additional aliases."
  }

  assert {
    condition     = length(aws_kms_grant.this) == 1
    error_message = "Configured KMS grants must be planned without depending on an apply-time key ID."
  }
}

run "external_key_pending_import" {
  command = plan

  variables {
    name                    = "external"
    create_external_enabled = true
    key_material_base64     = null
  }

  assert {
    condition     = length(aws_kms_external_key.external) == 1 && aws_kms_external_key.external[0].enabled == false
    error_message = "An external key without imported material must be created in PendingImport state."
  }
}

run "replica_enable_state" {
  command = plan

  variables {
    name                   = "replica"
    create_replica_enabled = true
    kms_key_enabled        = false
    primary_key_arn        = "arn:aws:kms:us-east-1:111122223333:key/mrk-example"
  }

  assert {
    condition     = aws_kms_replica_key.replica[0].enabled == false
    error_message = "kms_key_enabled must control replica keys as well as standard keys."
  }
}

run "reject_multiple_key_variants" {
  command = plan

  variables {
    name                    = "invalid-variants"
    create_external_enabled = true
    create_replica_enabled  = true
  }

  expect_failures = [check.key_variant]
}

run "reject_xks_without_store" {
  command = plan

  variables {
    enabled    = false
    xks_key_id = "external-key-id"
  }

  expect_failures = [check.xks_key_store]
}

run "reject_duplicate_primary_alias" {
  command = plan

  variables {
    name    = "duplicate-alias"
    alias   = "alias/duplicate"
    aliases = ["alias/duplicate"]
  }

  expect_failures = [check.alias_uniqueness]
}

run "reject_conflicting_grant_constraints" {
  command = plan

  variables {
    enabled = false
    grants = {
      invalid = {
        grantee_principal         = "arn:aws:iam::111122223333:role/application"
        operations                = ["Encrypt"]
        encryption_context_equals = { Environment = "test" }
        encryption_context_subset = { Application = "example" }
      }
    }
  }

  expect_failures = [var.grants]
}
