{
  description = "A flake for an AWS Glue Scala ETL scripting environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    spark = {
      url = "https://aws-glue-etl-artifacts.s3.amazonaws.com/glue-3.0/spark-3.1.1-amzn-0-bin-3.2.1-amzn-3.tgz";
      type = "tarball";
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
          
          # To run this outside of an EC2, we must set this to true.
          # "Disables the use of the Amazon EC2 instance metadata service (IMDS)."
          # https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html
          AWS_EC2_METADATA_DISABLED = "TRUE";
          
          # Use example keys from the AWS documentation.
          # We could alternatively leave these blank.
          AWS_ACCESS_KEY_ID = "AKIAIOSFODNN7EXAMPLE";
          AWS_SECRET_ACCESS_KEY = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY";

          # We must provide a region, though it does not need to be this one.
          AWS_REGION = "us-east-1";
        };
      });
}
