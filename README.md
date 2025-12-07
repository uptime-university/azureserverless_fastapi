# azureserverless_fastapi

This repository hosts **azureserverless_fastapi**, a project built primarily with **Python** and the **FastAPI** framework. Its goal is to serve as a foundation or template for building serverless APIs that can be deployed on Microsoft Azure.

## Key Features

- Built using **FastAPI**, enabling fast and robust API creation.
- Designed for deployment in **Azure Serverless** environments.
- Ready for integration with Azure infrastructure-as-code.
- Public repository for educational and development purposes.

## Typical Usage

1. Clone this repository:
   ```bash
   git clone https://github.com/uptime-university/azureserverless_fastapi.git
   ```
2. Install required Python packages (often via `pip` or using a `requirements.txt` file).
3. Run locally for development and testing.
4. Deploy to Azure for serverless API hosting.

## Infrastructure

- You can deploy this API as an **Azure Function** using the [Azure Functions Python worker](https://learn.microsoft.com/en-us/azure/azure-functions/functions-reference-python).
- Alternatively, host it using **Azure App Service** for persistent FastAPI applications.
- Infrastructure-as-Code templates (such as Bicep or ARM templates) can automate resource provisioning.
- Deployment files (such as `function.json`, or `host.json` for Azure Functions; or `web.config` for App Service) may need to be customized based on your needs.
- Example deployment steps:

    ```bash
    # Login to Azure CLI
    az login

    # Create resource group
    az group create --name myResourceGroup --location westeurope

    # Deploy Azure Function App
    az functionapp create --resource-group myResourceGroup --consumption-plan-location westeurope --runtime python --functions-version 4 --name <your-app-name> --os-type Linux --runtime-version 3.9 --storage-account <your-storage-account>
    ```

- For detailed deployment guides, consult the official documentation:
  - [FastAPI on Azure](https://learn.microsoft.com/en-us/azure/developer/python/quickstart-fastapi-webapp)
  - [Azure Functions Python](https://learn.microsoft.com/en-us/azure/azure-functions/functions-reference-python)
  - [App Service Deployment](https://learn.microsoft.com/en-us/azure/app-service/quickstart-python?tabs=cmd%2Cbrowser)

## Getting Started

- Ensure you have Python 3.7+ installed.
- Set up an Azure environment (such as Azure Functions or Azure App Service).
- Follow FastAPI deployment guides for Azure.

## Documentation

For details on project structure and customization, refer to the official [FastAPI Documentation](https://fastapi.tiangolo.com/) and [Azure Serverless Docs](https://learn.microsoft.com/en-us/azure/azure-functions/functions-overview).

## License

This repository currently does not specify a license.

## Maintainer

- [uptime-university](https://github.com/uptime-university)

---

For further queries or contributions, feel free to open an issue or pull request.