aws_eks_cluster_config = {

      "demo-cluster" = {

        eks_cluster_name         = "demo-cluster1"
        eks_subnet_ids = ["subnet-08fdfed4ce2b3f28a","subnet-0e54630b11b73828f"]
        tags = {
             "Name" =  "demo-cluster"
         }  
      }
}

eks_node_group_config = {

  "node1" = {

        eks_cluster_name         = "demo-cluster"
        node_group_name          = "myeksnode"
        nodes_iam_role           = "eks-node-group-general1"
        node_subnet_ids          = ["subnet-08fdfed4ce2b3f28a","subnet-0e54630b11b73828f"]
        tags = {
             "Name" =  "node1"
         } 
  }
}
