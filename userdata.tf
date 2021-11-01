data "template_cloudinit_config" "userdata" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = file("${path.module}/templates/user-data.yml")
  }

  part {
    content_type = "text/cloud-config"
    content = jsonencode({
      write_files = [
        {
          content     = file("${path.module}/templates/fail2ban_jaild_custom.conf")
          path        = "/etc/fail2ban/jail.d/custom.conf"
          permissions = "0600"
        },
        {
          content     = file("${path.module}/templates/ufw_before-ipv4.rules")
          path        = "/etc/ufw/before-ipv4.rules"
          permissions = "0600"
        },
        {
          content     = file("${path.module}/templates/ufw_before-ipv6.rules")
          path        = "/etc/ufw/before-ipv6.rules"
          permissions = "0600"
        },
        {
          content = templatefile("${path.module}/templates/wg0.conf.tpl", {
            publickey  = var.wg_publickey
            privatekey = var.wg_privatekey
          })
          path        = "/etc/wireguard/wg0.conf"
          permissions = "0600"
        },
        {
          content     = file("${path.module}/templates/wg_conf_restart.cron")
          path        = "/root/wg_conf_restart"
          permissions = "0600"
        },
        {
          content     = file("${path.module}/templates/wg_conf_restart.sh")
          path        = "/root/wg_conf_restart.sh"
          permissions = "0700"
        },
        {
          content     = file("${path.module}/templates/logrotate-syslog.conf")
          path        = "/etc/logrotate.d/rsyslog"
          permissions = "0644"
        },
        {
          content     = file("${path.module}/templates/logrotate-ufw.conf")
          path        = "/etc/logrotate.d/ufw"
          permissions = "0644"
        }
      ]
    })
  }
  part {
    content_type = "text/x-shellscript"
    content      = file("${path.module}/templates/run_on_setup.sh")

  }
}
