# AWS Glue Scala ETL Flake

Hello!

This repository is meant to serve as an example of how easy the Nix
package manager (<https://nixos.org>) can (well, almost[^1]) make
setting up an otherwise irritating environment.

Roughly, this flake downloads the necessary blobs and libraries, sets
the relevant environment variables, and gives you a shell to develop and
run AWS Glue jobs.

## Testing the flake

After cloning this repository, run the following three commands:

1.  `nix develop`
    -   Starts a nix shell with all the tools the glue application needs
        available to it
2.  `sbt pack`
    -   Exports a copy of the Glue `jar`s we need to run the app
    -   `spark-conf/spark-defaults.conf` is already set up to put this
        on the classpath for us
3.  `$SPARK_HOME/bin/spark-submit --class GlueApp target/scala-2.12/glue-app_2.12-0.1.0-SNAPSHOT.jar`
    -   Submits the glue job
    -   Takes the newline-delimited JSON file `data/in/data.ndjson`,
        partitions it on the first key, and writes the results to
        `data/out`

[^1]: A tiny asterisk here -- Nix flakes supports fetching [several
    kinds of
    archives](https://github.com/NixOS/nix/blob/2e606e87c44a8dc42664f8938eac1d4b63047dd6/src/libfetchers/tarball.cc#L177).
    However, this flake requires an Amazon-provided `.tgz` archive, an
    extension which Nix flakes are not hard-coded to support, even
    though [it is synonymous](https://stackoverflow.com/a/11535002) with
    the flake-supported `.tar.gz` format.
