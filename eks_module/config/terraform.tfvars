aws_eks_cluster_config = {

      "demo-cluster1" = {

        eks_cluster_name         = "demo-cluster2"
        eks_subnet_ids           = ["subnet-04381921f77511657","subnet-05ff5b57596e11c4c"]
        tags = {
             "Name" =  "demo-cluster1"
         }  
      }
}

eks_node_group_config = {

  "node2" = {

        eks_cluster_name         = "demo-cluster1"
        node_group_name          = "myeksnode1"
        nodes_iam_role           = "eks-node-group-general1"
        node_subnet_ids          = ["subnet-04381921f77511657","subnet-05ff5b57596e11c4c"]
        tags = {
             "Name" =  "node2"
         } 
  }
}
