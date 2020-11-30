data "template_file" "policy" {
  template = "${file("${path.module}/policy.json")}"

  vars {
    bucket_name = "bucket123"
  }
}

resource "aws_iam_user" "instanceManageUser" {
    name = "instanceManageUser"
}

# resource "aws_iam_access_key" "instanceManageUser" {
#     user = "${aws_iam_user.instanceManageUser.name}"
# }

resource "aws_iam_user_policy" "instanceManageUser_assume_role" {
    name = "InstanceManagePolicy"
    user = "${aws_iam_user.instanceManageUser.name}"

    policy ="${data.template_file.policy.rendered}"
}