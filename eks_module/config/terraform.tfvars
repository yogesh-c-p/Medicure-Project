aws_eks_cluster_config = {

      "demo-cluster" = {

        eks_cluster_name         = "demo-cluster1"
        eks_subnet_ids           = ["subnet-059371fe6aa80a450","subnet-0056808224bae551b"]
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
        node_subnet_ids          = ["subnet-059371fe6aa80a450","subnet-0056808224bae551b"]
        tags = {
             "Name" =  "node1"
         } 
  }
}
