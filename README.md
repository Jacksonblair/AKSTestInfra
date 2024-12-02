## Creating Azure Service Principal

1. Create Azure Service Pricipal

```
az ad sp create-for-rbac --name test-aks-sp --role Contributor --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group-name}
```

Example Result:

```json
{
    "appId": "*************",
    "displayName": "*********",
    "password": "**********",
    "tenant": "*************"
}
 ```

2. Store results in Github secrets

## Deploying... something.... 

1. ....