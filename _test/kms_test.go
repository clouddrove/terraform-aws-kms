// Managed By : CloudDrove
// Description : This Terratest is used to test the Terraform KMS module.
// Copyright @ CloudDrove. All Right Reserved.

package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func Test(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		// Source path of Terraform directory.
		TerraformDir: "../_example",
	}

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// To clean up any resources that have been created, run 'terraform destroy' towards the end of the test
	defer terraform.Destroy(t, terraformOptions)

	// To get the value of an output variable, run 'terraform output'
	keyArn := terraform.Output(t, terraformOptions, "key_arn")
	Tags := terraform.OutputMap(t, terraformOptions, "tags")

	// Check that we get back the outputs that we expect
	assert.Contains(t, keyArn, "arn:aws:kms")
	assert.Equal(t, "kms-test", Tags["Name"])
}
