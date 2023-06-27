aws_eks_cluster_config = {

      "demo-cluster" = {

        eks_cluster_name         = "demo-cluster1"
        eks_subnet_ids           = ["subnet-0e54630b11b73828f","subnet-05ff5b57596e11c4c"]
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
        node_subnet_ids          = ["subnet-0e54630b11b73828f","subnet-05ff5b57596e11c4c"]
        tags = {
             "Name" =  "node1"
         } 
  }
}
