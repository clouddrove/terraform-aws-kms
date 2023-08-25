# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.3.1] - 2023-08-25
### :sparkles: New Features
- [`b3d8b40`](https://github.com/clouddrove/terraform-aws-kms/commit/b3d8b4021a72d8a758e20d15b56761b3337e0485) - add deepsource & added assignees,reviewer in dependabot *(commit by [@Tanveer143s](https://github.com/Tanveer143s))*
- [`49cc3e9`](https://github.com/clouddrove/terraform-aws-kms/commit/49cc3e9ce3936b509a95b4575cc9204dd924748f) - added resource and variable *(commit by [@theprashantyadav](https://github.com/theprashantyadav))*
- [`59c8ad2`](https://github.com/clouddrove/terraform-aws-kms/commit/59c8ad219d9583f58b5c108456b8e466c24a7b51) - added external key resource *(commit by [@theprashantyadav](https://github.com/theprashantyadav))*
- [`946056c`](https://github.com/clouddrove/terraform-aws-kms/commit/946056ccc160a35f860adf3383e621d69410d045) - added external key resource *(commit by [@theprashantyadav](https://github.com/theprashantyadav))*
- [`c651142`](https://github.com/clouddrove/terraform-aws-kms/commit/c651142bc29e3a29c7db56c8f524ad83cc9bd980) - changes module description *(commit by [@theprashantyadav](https://github.com/theprashantyadav))*
- [`dd64c5c`](https://github.com/clouddrove/terraform-aws-kms/commit/dd64c5c5f8d2cef2623858d26c603d0fe6992031) - added policy data description *(commit by [@theprashantyadav](https://github.com/theprashantyadav))*
- [`f7cffa3`](https://github.com/clouddrove/terraform-aws-kms/commit/f7cffa36d3a2d56b71987c461fe50f334bdd9161) - added policy data description *(commit by [@theprashantyadav](https://github.com/theprashantyadav))*
- [`9e6a893`](https://github.com/clouddrove/terraform-aws-kms/commit/9e6a893365d61465fd172e8b0188c5e51f55a316) - added description and update example.tf *(commit by [@theprashantyadav](https://github.com/theprashantyadav))*
- [`0d2a455`](https://github.com/clouddrove/terraform-aws-kms/commit/0d2a455de7526435bfa14f480692f9782e9f57c4) - added description and update example.tf *(commit by [@theprashantyadav](https://github.com/theprashantyadav))*
- [`f59fbc3`](https://github.com/clouddrove/terraform-aws-kms/commit/f59fbc375ebd5b50f4e7035c109aa664c80d06a3) - added Replica-Key and Replica-External-Key(CMK) *(commit by [@h1manshu98](https://github.com/h1manshu98))*
- [`bb380b0`](https://github.com/clouddrove/terraform-aws-kms/commit/bb380b0cb14bd0b85e34d6d18d6adccc0d23e557) - Added example for replica key. *(commit by [@13archit](https://github.com/13archit))*

### :bug: Bug Fixes
- [`95144e7`](https://github.com/clouddrove/terraform-aws-kms/commit/95144e7a4192733a2275ac849133c81218534652) - Update workflows and examples *(commit by [@13archit](https://github.com/13archit))*
- [`caa35b8`](https://github.com/clouddrove/terraform-aws-kms/commit/caa35b8899864631f08959d43d17d6b3d0a5611c) - Update tf-checks workflow *(commit by [@13archit](https://github.com/13archit))*
- [`0d23637`](https://github.com/clouddrove/terraform-aws-kms/commit/0d236376fb3bfabb24b56ac51d80d49a72c49d56) - Fixed tfsec and tflint workflow *(commit by [@13archit](https://github.com/13archit))*


## [1.3.0] - 2022-12-30
### :bug: Bug Fixes
- [`77519cb`](https://github.com/clouddrove/terraform-aws-kms/commit/77519cb4d997633fd5d1b90fd33cdd11f6da7676) - update workflows.
- [`d9e6491`](https://github.com/clouddrove/terraform-aws-kms/commit/d9e64911a2f67f8e599d7244cdce43dd24a3860b) - Update README.yaml.


## [1.0.1] - 2022-04-6
### :bug: Bug Fixes
- [`c5c0f28`](https://github.com/clouddrove/terraform-aws-kms/commit/c5c0f28b88d536ea6bec33a5f4787a8bfe4e1160) - update terraform letest version
- [`679952f`](https://github.com/clouddrove/terraform-aws-kms/commit/679952f21d9b36a4b429798783cc97917f0a4b59) - disable public kms
- [`b53331b`](https://github.com/clouddrove/terraform-aws-kms/commit/b53331b94764af6df017d0c9fc78e365ef603352) - Add multi_region argument


## [0.15.0] - 2021-07-09
### :bug: Bug Fixes
- [`c5c0f28`](https://github.com/clouddrove/terraform-aws-kms/commit/c5c0f28b88d536ea6bec33a5f4787a8bfe4e1160) - update terraform letest version
- [`679952f`](https://github.com/clouddrove/terraform-aws-kms/commit/679952f21d9b36a4b429798783cc97917f0a4b59) - disable public kms
- [`b53331b`](https://github.com/clouddrove/terraform-aws-kms/commit/b53331b94764af6df017d0c9fc78e365ef603352) - Add multi_region argument
- [`0edd553`](https://github.com/clouddrove/terraform-aws-kms/commit/0edd553af020fc45bd505b8e3c00e05cbeab9248) - fix tfsec
- [`b5e98ef`](https://github.com/clouddrove/terraform-aws-kms/commit/b5e98ef5e0fd95bf8a44e6598ea6b5ae58b1dbf9) - update github-action

## [0.14.0] - 2021-05-20
### :sparkles: New Features
- [`662929b`](https://github.com/clouddrove/terraform-aws-kms/commit/662929b9943147b77da8e2ee93578d423160148a) - added security check for key rotation
- [`b53331b`](https://github.com/clouddrove/terraform-aws-kms/commit/b53331b94764af6df017d0c9fc78e365ef603352) - Add multi_region argument


### :bug: Bug Fixes
- [`c5c0f28`](https://github.com/clouddrove/terraform-aws-kms/commit/c5c0f28b88d536ea6bec33a5f4787a8bfe4e1160) - update terraform letest version
- [`679952f`](https://github.com/clouddrove/terraform-aws-kms/commit/679952f21d9b36a4b429798783cc97917f0a4b59) - disable public kms
- [`0edd553`](https://github.com/clouddrove/terraform-aws-kms/commit/0edd553af020fc45bd505b8e3c00e05cbeab9248) - fix tfsec
- [`0f4e7b5`](https://github.com/clouddrove/terraform-aws-kms/commit/0f4e7b53d31e81e4a4f0ecdc61b5e77569dd6369) - update githubaction
- [`186f843`](https://github.com/clouddrove/terraform-aws-kms/commit/186f84360e43694e56de2241d4ecf55e7facc42e) - fix terratest
- [`1cc19c1`](https://github.com/clouddrove/terraform-aws-kms/commit/1cc19c1cf1484cf6f51ab749e3ac20fac5c5c021) - removed unused variable from example.tf

## [0.13.0] - 2021-01-15
### :bug: Bug Fixes
- [`c5c0f28`](https://github.com/clouddrove/terraform-aws-kms/commit/c5c0f28b88d536ea6bec33a5f4787a8bfe4e1160) - update terraform letest version
- [`679952f`](https://github.com/clouddrove/terraform-aws-kms/commit/679952f21d9b36a4b429798783cc97917f0a4b59) - disable public kms
- [`697da46`](https://github.com/clouddrove/terraform-aws-kms/commit/697da46e385cb4cf3c0e55f4f783f86f88f79365) - fix tfsec

### :sparkles: New Features
- [`b53331b`](https://github.com/clouddrove/terraform-aws-kms/commit/b53331b94764af6df017d0c9fc78e365ef603352) - Add multi_region argument
- [`662929b`](https://github.com/clouddrove/terraform-aws-kms/commit/662929b9943147b77da8e2ee93578d423160148a) - added security check for key rotation


## [0.12.5] - 2020-03-30
### :bug: Bug Fixes
- [`1cc19c1`](https://github.com/clouddrove/terraform-aws-kms/commit/1cc19c1cf1484cf6f51ab749e3ac20fac5c5c021) - removed unused variable from example.tf
- [`c5c0f28`](https://github.com/clouddrove/terraform-aws-kms/commit/c5c0f28b88d536ea6bec33a5f4787a8bfe4e11601) - update terraform letest version
- [`679952f`](https://github.com/clouddrove/terraform-aws-kms/commit/679952f21d9b36a4b429798783cc97917f0a4b59) - disable public kms


## [0.12.4] - 2019-12-27
### :bug: Bug Fixes
- [`bdaa1cf`](https://github.com/clouddrove/terraform-aws-kms/commit/bdaa1cfe2ac5e2cb533bbcba45b1dd41326d25da) - disable public kms
- [`44608e5`](https://github.com/clouddrove/terraform-aws-kms/commit/44608e5a75f77afdb365fbe5493ce1b1aa5c78d4) - Updated Files
- [`4de2b28`](https://github.com/clouddrove/terraform-aws-kms/commit/4de2b2888ed611085be1356de7ae3d86c34162dd) - pipeline updated

## [0.12.3] - 2019-09-24
### :bug: Bug Fixes
- [`b53331b`](https://github.com/clouddrove/terraform-aws-kms/commit/b53331b94764af6df017d0c9fc78e365ef603352) - Add multi_region argument
- [`0edd553`](https://github.com/clouddrove/terraform-aws-kms/commit/0edd553af020fc45bd505b8e3c00e05cbeab9248) - fix tfsec
- [`662929b`](https://github.com/clouddrove/terraform-aws-kms/commit/662929b9943147b77da8e2ee93578d423160148a) - added security check for key rotation

## [0.12.2] - 2019-09-14
### :bug: Bug Fixes
- [`846d66a`](https://github.com/clouddrove/terraform-aws-kms/commit/846d66a3eb6f73452d64e69397d796757cfb371f) - update in 0.15
- [`287f7d1`](https://github.com/clouddrove/terraform-aws-kms/commit/287f7d1cf6043a57cafe1b1fb8728690cddbe339) - fix tfsec
- [`95075ab`](https://github.com/clouddrove/terraform-aws-kms/commit/95075abf50a53a28e44a528a0b24431ac7933760) - Upgrade terraform version to 0.13.0
- [`1c57b5b`](https://github.com/clouddrove/terraform-aws-kms/commit/1c57b5bcfed1d2509d5d2ae966cb362804002907) - fix labels managedby variables


## [0.12.1] - 2019-09-05
### :bug: Bug Fixes
- [`a9313cf`](https://github.com/clouddrove/terraform-aws-kms/commit/a9313cf8fd5ab58bc917d54f2584c33ca8aa635d) - update module tags
- [`cd3f529`](https://github.com/clouddrove/terraform-aws-kms/commit/cd3f52989be9c81b59283dbc93e3e068dfcf8bf0) - update in 0.15
- [`662929b`](https://github.com/clouddrove/terraform-aws-kms/commit/662929b9943147b77da8e2ee93578d423160148a) - added security check for key rotation
- [`aaa0c58`](https://github.com/clouddrove/terraform-aws-kms/commit/aaa0c583fa4d47a9bad3c74b53e61651e22a675b) - add count

## [0.12.0] - 2019-08-12
### :bug: Bug Fixes
- [`ebd77ca`](https://github.com/clouddrove/terraform-aws-kms/commit/ebd77cade5ac2115515dc702bac5e353d502c4bb) - update url
- [`44608e5`](https://github.com/clouddrove/terraform-aws-kms/commit/44608e5a75f77afdb365fbe5493ce1b1aa5c78d4) - Updated Files
- [`edbe951`](https://github.com/clouddrove/terraform-aws-kms/commit/edbe951e7a788b018f444bc14822c5b3a9e4b684) - update labels version


## [0.11.0] - 2019-08-12
### :bug: Bug Fixes
- [`00b07d9`](https://github.com/clouddrove/terraform-aws-kms/commit/00b07d90b8740acd0a35fc1ed66099bb9d106a31) - terraform 0.12.0
- [`ebd77ca`](https://github.com/clouddrove/terraform-aws-kms/commit/ebd77cade5ac2115515dc702bac5e353d502c4bb) - update url
- [`662929b`](https://github.com/clouddrove/terraform-aws-kms/commit/662929b9943147b77da8e2ee93578d423160148a) - added security check for key rotation



[0.11.0]: https://github.com/clouddrove/terraform-aws-kms/compare/0.11.0...master
[0.12.0]: https://github.com/clouddrove/terraform-aws-kms/compare/0.11.0...0.12.0
[0.12.1]: https://github.com/clouddrove/terraform-aws-kms/compare/0.12.0...0.12.1
[0.12.2]: https://github.com/clouddrove/terraform-aws-kms/compare/0.12.1...0.12.2
[0.12.3]: https://github.com/clouddrove/terraform-aws-kms/compare/0.12.2...0.12.3
[0.12.4]: https://github.com/clouddrove/terraform-aws-kms/compare/0.12.3...0.12.4
[0.12.5]: https://github.com/clouddrove/terraform-aws-kms/compare/0.12.4...0.12.5
[0.13.0]: https://github.com/clouddrove/terraform-aws-kms/compare/0.12.5...0.13.0
[0.14.0]: https://github.com/clouddrove/terraform-aws-kms/compare/0.13.0...0.14.0
[0.15.0]: https://github.com/clouddrove/terraform-aws-kms/compare/0.14.0...0.15.0
[1.0.1]:  https://github.com/clouddrove/terraform-aws-kms/compare/0.15.0...1.0.1
[1.3.0]:  https://github.com/clouddrove/terraform-aws-kms/compare/1.0.1...1.3.0
[1.3.1]: https://github.com/clouddrove/terraform-aws-kms/compare/1.3.0...1.3.1