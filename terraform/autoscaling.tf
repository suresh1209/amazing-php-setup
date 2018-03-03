resource "aws_launch_configuration" "glofox-launchconfig" {
  name_prefix     = "glofox-launchconfig"
  image_id        = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type   = "t2.micro"
  key_name        = "${aws_key_pair.glofoxKeypair.key_name}"
  security_groups = ["${aws_security_group.allow-ssh.id}"]
  user_data       = "${data.template_cloudinit_config.cloudinit.rendered}"
}

resource "aws_autoscaling_group" "glofox-autoscaling" {
  name                      = "glofox-autoscaling"
  vpc_zone_identifier       = ["${aws_subnet.glofox-public-1a.id}", "${aws_subnet.glofox-public-1b.id}"]
  launch_configuration      = "${aws_launch_configuration.glofox-launchconfig.name}"
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers            = ["${aws_elb.glofox-elb.name}"]
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "glofox-amazing-app"
    propagate_at_launch = true
  }
}
