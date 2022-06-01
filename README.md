# Au10tix Secure.Me Implementation Example - iOS

## Table of Contents
- [Overview](#overview)
- [Usage](#usage)
    - [Permissions](#permissions)
- [Change log](#change-log)

## Overview
Verified, compliant and fraud-free onboarding results in 8 seconds (or less). By the time you read this sentence, AU10TIX would have converted countless human smiles, identity documents and data points into authenticated, all-access passes to your products, services and experiences.

This example application presents an implementation suggestion for the Au10tix Secure.Me Web View App.

## Usage

To use this sample you have to generate a link in the Au10tix Console. Paste a link and run the flow.


### Permissions
The AU10TIX SDK uses the device location and camera to produce photos containing metadata relevant to the authentication process. 
Both Camera and Location permissions must be declared, requested, and granted for the SDK to behave as expected.
You declare privacy permission usage descriptions in the info.plist of your application.
If you are viewing your application’s info.plist file as a property list, you need to add usage description strings for the following property list keys:

    * Privacy - Camera Usage Description
    * Privacy - Location When in Use Usage Description

## Change log
See [Change log](changelog.md) page for more details

