---
layout: post
title:  "Ideas for a Linux class at Unallocated Space"
---

In-progress ideas for a Linux class.

This post will be updated as the class is fleshed out.

## Background
Flay, the current president of the [Unallocated
Space](https://www.unallocatedspace.org/) organization, would like to finish
development of a [fast-paced introduction to
Linux](https://www.unallocatedspace.org/events/linux-102/).

## Engineering constraints

* **Limited virtualization capabilities**.  The space currently does not have a
    VMware license available.  An open source solution involving
    [KVM](https://www.linux-kvm.org/page/Main_Page),
    [Qemu](https://www.qemu.org/), and the
    [Kimchi](https://github.com/kimchi-project/kimchi) web-based management
    tool is possible but seems to be having stability issues.  We need
    something rock solid so that we don't risk the class being derailed by
    technical difficulties.
* **Zero configuration/installation**.  While it may be feasible to ask
    students to install an SSH client suitable for their OS (PuTTY for Windows,
    for example), technical difficulties with installation could delay
    presentation of class content.  We would prefer to require only a computing
    device with a web browser.
* **Isolated environment for each user**.  We don't want participants to share
    login information.  That way, if one participant borks their setup, other
    participants will not be affected.

## Instruction platform
Since Linux is a multiuser operating system, it's relatively straightforward to
satisfy these engineering constraints using old school technology.

We will set up Linux on one reasonably beefy computer.  We'll run an SSH
server and a web server that serves up an SSH client web application.  We'll
write a script to generate and delete participant accounts on demand.

### SSH server
The SSH server will be configured to use username/password authentication.
It's not key-based auth but it's the easiest thing for this class.

### SSH client web application
The MIT-licensed [webssh](https://pypi.org/project/webssh/) library provides a
turnkey SSH client web application.  I have verified that it runs on MacOS with
Python 3.7.2.

Basic setup is trivial with `pipenv`:
```
pipenv --python 3.7
pipenv install webssh
```
Running on localhost without SSL is similarly trivial:

```
wssh
```
The `wssh` server can serve multiple SSH pages at once.  I haven't load tested
it but it will probably be fine for the workload involved in the class.

We would like to run an HTTPS server so as to not entirely defeat the purpose
of SSH.  That'll require creating a certificate file.  We can either create a
self-signed certificate and explain to users why the certificate is untrusted,
or we can go through the trouble of registering a domain and getting a real
cert through e.g. Let's Encrypt.  I would recommend the self-signed certificate
approach as I think it's the right balance between minimizing prior preparation
and minimizing risk of class derailment.

So we'll be script kiddies and follow the Heroku instructions for [generating a
self-signed
certificate](https://devcenter.heroku.com/articles/ssl-certificate-self).  Run
this and follow the prompts.

```
openssl genrsa -des3 -passout pass:x -out server.pass.key 2048
openssl rsa -passin pass:x -in server.pass.key -out server.key
rm server.pass.key
openssl req -new -key server.key -out server.csr
openssl x509 -req -sha256 -days 365 -in server.csr -signkey server.key -out server.crt
```

Then run `wssh` with SSL:
```
wssh --port=8080 --sslport=4433 --certfile='server.crt' --keyfile='server.key' --xheaders=False
```
Connecting to `https://[server ip]:4433` will result in security exceptions.

#### Handling security exceptions
We recommend using either Firefox or Chrome to visit the `wssh` web application
that we've configured with a self-signed certificate.  In those browsers,
visiting web sites with self-signed certificates doesn't require modification
of system security settings.

##### Firefox
In Firefox we'll get a "Your connection is not secure" page due to a
`MOZILLA_PKIX_ERROR_SELF_SIGNED_CERT`.  We'll need to add a security exception.
Don't add it permanently.

##### Safari
In Safari we'll get a "Your connection is not private" page.  After clicking
"Show Details", click "visit this website".  However, this requires modifying
system security settings, which we don't recommend doing.

##### Chrome
In Chrome we'll get a "Your connection is not private" page that displays a
`NET::ERR_CERT_AUTHORITY_INVALID` error.  After clicking "Advanced", we can
"Proceed to localhost (unsafe)".

### User accounts
We'll create a separate username and password for each class participant.  We
can distribute credentials on sticky notes as the accounts will be nuked after
the class is finished.  We'll create accounts on demand.  If a user borks their
session, we'll just create a new account for them rather than spending too much
time troubleshooting.
