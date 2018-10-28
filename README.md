# Repo Explorer

Explore git repositories from within Salesforce.

This application comes with out-of-the-box support for repositories hosted on:

* Github
* Bitbucket
* Gitlab

For now it only supports the following actions:

* List available repositories for a user / group / team. 

## Usage

After authenticating your hosting service you should be good to go, so you can just go to the Lightning App Builder and add the `GitRepoList` component to the Lightning Page you want or just invoke it from another Lightning Component of yours.


## Configuration

Before using the supplied Lightning Component you must first authenticate your org with the Hosting Service you want to use.


### Auth. Providers

You'll need to configure the appropriate Auth. Providers to use a valid `client id` and `client secret` (refer to the [Resources section](#resources) for more info on how to create an application for each service to obtain this values).

* Proceed to `Setup > Identity > Auth. Providers`.
* Click `Edit` next to the Auth. Provider you want to use.
* Change the `Consumer Key` and `Consumer Secret` with the corresponding `client id` and `client secret` from the application you created in your hosting service.
* In the Auth. Provider detail page you'll see a `Callback URL`, make sure you use that one when configuring your hosting service application.


### Named Credentials

Once we have a valid Auth. Provider we can then proceed to authenticate a user so our component can integrate with the hosting service in an authenticated fashion.

* Proceed to `Setup > Security > Named Credentials`.
* Click `Edit` next to the Named Credential you want to use.
* The `Authentication Status` should show `Pending`.
* Make sure the `Start Authentication Flow on Save` checkbox is checked.
* Click `Save`.
* A popup with the hosting service login and authorization request would be presented.
* After authorization the Named Credential `Authentication Status` should show `Authenticated`.

If you encounter issues in this step, make sure you've configured correctly the application in you hosting service with the right scopes and callback url.


## Other hosting services

In case you want to use other hosting service that's not listed in the supported ones, you'll need to follow this steps:

* Create an Auth. Provider for your hosting service.
* Create a Named Credential related to your Auth. Provider and authenticate it.
* Create an apex class extending from the `GitHostingService` class and implement the required methods.
* Create a new entry in the `Git Hosting Service` custom metadata with the appropiate information from the hosting service you're creating.

If you think others in the community could benefit from this new hosting service configuration, please make a pull request and contribute it (make sure to not include your Auth. Provider `client id` and `client secret`).

## Resources

Here you can find some information on how to create an application in the supported hosting services so you can link it to the Auth. Provider.

**Remember to use the callback URL supplied by the Auth. Provider configuration.**

### Github
* [Basics of Authentication](https://developer.github.com/v3/guides/basics-of-authentication/#registering-your-app)

### Bitbucket
* [OAuth in Bitbucket Cloud](https://confluence.atlassian.com/bitbucket/oauth-on-bitbucket-cloud-238027431.html#OAuthonBitbucketCloud-Createaconsumer)

### Gitlab
* [Integrate your server with Gitlab.com](https://docs.gitlab.com/ee/integration/gitlab.html)

## Dev, Build and Test

* Make sure you have [sfdx](https://developer.salesforce.com/tools/sfdxcli) installed.
* Fork this repo.
* Clone your fork to your machine.
* Spin up a scratch org:

`sfdx force:org:create -s -a RepoExplorer -v DevHub -f config/project-scratch-def.json`.

* Push source to the scratch org:

`sfdx force:source:push`

* Make your changes and get crazy!
