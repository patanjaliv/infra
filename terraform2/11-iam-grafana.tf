data "aws_iam_policy_document" "grafana_patanjali" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:monitoring:grafana"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "grafana_patanjali" {
  assume_role_policy = data.aws_iam_policy_document.grafana_patanjali.json
  name               = "grafana-patanjali"
}

resource "aws_iam_role_policy_attachment" "grafana_patanjali_query_access" {
  role       = aws_iam_role.grafana_patanjali.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonPrometheusQueryAccess"
}
