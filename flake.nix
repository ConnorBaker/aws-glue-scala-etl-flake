{
  description = "A flake for an AWS Glue Scala ETL scripting environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    spark = {
      url = "https://aws-glue-etl-artifacts.s3.amazonaws.com/glue-3.0/spark-3.1.1-amzn-0-bin-3.2.1-amzn-3.tgz";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, spark }:
    flake-utils.lib.eachDefaultSystem (system:
      with nixpkgs.legacyPackages.${system};
      {
        defaultPackage = mkShell {
          buildInputs = [
            sbt
            jdk8
          ];
          SPARK_HOME = spark;
          SPARK_CONF_DIR = "spark-conf";
          AWS_EC2_METADATA_DISABLED = "TRUE";
          AWS_ACCESS_KEY_ID = "AKIAIOSFODNN7EXAMPLE";
          AWS_SECRET_ACCESS_KEY = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY";
          AWS_REGION = "us-east-1";
        };
      });
}
