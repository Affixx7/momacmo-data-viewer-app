export type AmplifyDependentResourcesAttributes = {
    "auth": {
        "photoviewerf2ea1f67": {
            "IdentityPoolId": "string",
            "IdentityPoolName": "string",
            "UserPoolId": "string",
            "UserPoolArn": "string",
            "UserPoolName": "string",
            "AppClientIDWeb": "string",
            "AppClientID": "string"
        },
        "userPoolGroups": {
            "Group001GroupRole": "string",
            "GuestGroupRole": "string"
        }
    },
    "analytics": {
        "photoviewer": {
            "Region": "string",
            "Id": "string",
            "appName": "string"
        }
    },
    "storage": {
        "s3photoviewerstorage71959dfc": {
            "BucketName": "string",
            "Region": "string"
        }
    },
    "api": {
        "photoviewer": {
            "GraphQLAPIKeyOutput": "string",
            "GraphQLAPIIdOutput": "string",
            "GraphQLAPIEndpointOutput": "string"
        }
    }
}