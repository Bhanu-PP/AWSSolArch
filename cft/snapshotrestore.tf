"AWSTemplateFormatVersion" = "2010-09-09"

"Description" = "Redshift CFN Blog Cluster Stack"

"Parameters" "MasterUserPasswordParam" {
  "NoEcho" = true

  "Type" = "String"

  "Description" = "Enter Master User Password"
}

"Resources" "RedshiftCluster" {
  "Type" = "AWS::Redshift::Cluster"

  "Properties" = {
    "SnapshotIdentifier" = "rs:democluster-5bd3e16b-2022-02-18-01-01-12"

    "ClusterIdentifier" = "cfn-blog-redshift-cluster"

    "ClusterType" = "multi-node"

    "NodeType" = "ra3.4xlarge"

    "NumberOfNodes" = "2"

    "DBName" = "dev"

    "MasterUsername" = "username"

    "Encrypted" = true

    "MasterUserPassword" = {
      "Ref" = "MasterUserPasswordParam"
    }
  }
}

"Outputs" "ClusterName" "Value" {
  "Ref" = "RedshiftCluster"
}