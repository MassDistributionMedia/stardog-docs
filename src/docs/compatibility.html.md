---
quote: Don't have good ideas if you aren't willing to be responsible for them.
title: What 1.x Means
layout: "default"
toc: true
shortTitle: Compatibility
---

## Introduction

The Stardog 1.x release ("Stardog" for short) is a major milestone in
the development of the system. Stardog is a stable platform for the
growth of projects and programs written for Stardog.

Stardog provides (and defines) several user-visible things:

1.  SNARL API
2.  BigPacket Message Format
3.  Stardog Extended HTTP Protocol
4.  a command-line interface

It is intended that programs—as well as SPARQL queries—written to
Stardog APIs, protocols, and interfaces will continue to run correctly,
unchanged, over the lifetime of Stardog.That is, over all releases
identified by version `1.x`. At some indefinite point, Stardog 2.0 may
be released; but, until that time, Stardog programs that work today
should continue to work even as future releases of Stardog (1.1, 1.2,
1.3, etc.) occur.

APIs, protocols, and interfaces may grow, acquiring new parts and
features, but not in a way that breaks existing Stardog programs.

## Expectations

Although we expect that nearly all Stardog programs will maintain this
compatibility over time, it is impossible to guarantee that no future
change will break any program. This document sets expectations for the
compatibility of Stardog programs in the future. The main, foreseeable
reasons for which this compatibility may be broken in the future
include:

1.  **Security**: We reserve the right to break compatibility if doing
    so is required to address a security problem in Stardog.
2.  **Unspecified behavior**: Programs that depend on unspecifiedThe
    relevant specs include the Stardog-specific specifications
    documented on this site, but also W3C (and other) specifications of
    various languages, including SPARQL, RDF, RDFS, OWL 2, HTTP, Google
    Protocol Buffers, as well as others. behaviors may not work in the
    future if those behaviors are modified.
3.  **3rd Party Specification Errors**: It may become necessary to break
    compatibility of Stardog programs in order to address problems in
    some 3rd party specification.
4.  **Bugs**: It will not always be possible to fix bugs found in
    Stardog—or in its 3rd party dependencies—while also preserving
    compatibility. With that proviso, we will endeavor to only break
    compatibility when repairing critical bugs.

It is always possible that the performance of a Stardog program may be
(adversely) affected by changes in the implementation of Stardog. No
guarantee can be made about the performance of a given program between
releases, except to say that our expectation is that performance will
generally trend in the appropriate direction.

## Data Migration & Safety

Finally, we expect that data safety will always be given greater weight
than any other consideration. But since Stardog stores user data
differently from the form in which data is input to Stardog, we may from
time to time change the way it is stored such that explicit data
migration will be necessary.

Stardog provides for two data migration strategies:

1.  Command-line migration tool(s)
2.  Dump and reload

We expect that explicit migrations may be required from time to time
between different releases of Stardog 1.0 (that is, 1.1, 1.2, etc.). We
will endeavor to minimize the need for such migrations. We will only
require the "dump and reload" strategy between *major* releases of
Stardog (that is, from 1.x to 2.x, etc.), unless that strategy of
migration is required to repair a security or other data safety bug in
Stardog 1.x.
