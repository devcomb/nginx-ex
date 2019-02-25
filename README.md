# OAuth Proxy Interface via Nginx reverse proxy and Node.js S2I Application

[OAuth Proxy for OpenShift](https://github.com/openshift/oauth-proxy) provide an almost ready to interface with OpenShift's backend authentication server. The lacking feature that was needed was to be able to split traffic based on user creditials. Nginx has the ability to split traffic but found that getting it to authenticate against Openshift's backend authentication directly to be difficult. Nginx is interfaced with Openshift's Oauth Proxy to allow for custom proxying ability of Nginx through it's built in configuration and to allow easy integration with Openshift's backend authentication with Oauth Proxy.

Although Nginx can split traffic based on header information received back from [OAuth Proxy for OpenShift](https://github.com/openshift/oauth-proxy) it lacks the ability to get useful information about the user authenticated by OAuth Proxy. Node.js server application was created to provide Nginx additional information for the user creditials(email/username) passed back from OAuth Proxy. 

Node.js and OAuth Proxy both use [Openshift's Service Account](https://docs.openshift.com/container-platform/3.11/admin_guide/service_accounts.html) to gain access to Openshift's authentication backend and user creditials. Service accounts can be easily created by any user per namespace(project). Limited information about the user is passed from Openshift's backend authentication and OAuth Proxy such as username/email. With username/email information the Node.js application can use a service account to access membership information for that particular user namespace's [rolebindings](https://docs.openshift.com/container-platform/3.11/architecture/additional_concepts/authorization.html) through OpenShift's REST api calls. Node.js will then send response back to Nginx client on if the requesting user has particular role and proxy user accordingly.

Node.js OAuth and Nginx server applications are meant to be run in a seperate namespace than Nginx client. This allows for Nginx client to be used in different namespaces(projects) and modified per to meet particular namespace application proxy needs. Nginx client in the repository should be considered a template while Node.js OAuth and Nginx server applications should not require any changes. Except currently service account in server namespace will require adding additional redirect urls for Openshift's backend authentication to communicate with. Eventually it is planned to provide a mechanism to automatically update the service account from the client using possibly a private and public key setup as an option.

This README is still a work in progress. Example use case and additional documentation to follow.

Copyright (c) 2019 James Drummond
This program and the accompanying materials are made
available under the terms of the Eclipse Public License 2.0
which is available at https://www.eclipse.org/legal/epl-2.0/
SPDX-License-Identifier: EPL-2.0
