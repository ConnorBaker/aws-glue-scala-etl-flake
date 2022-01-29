# AWS Glue Scala ETL Flake

This repository is meant to serve as an example of how easy the Nix
package manager (<https://nixos.org>) can make setting up an otherwise
irritating environment.

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
