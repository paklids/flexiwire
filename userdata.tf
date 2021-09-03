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
          content = templatefile("${path.module}/templates/docker-compose.tpl", {
            dynu_api_key  = var.dynu_api_key
            dynu_domain   = var.dynu_domain
            wgui_username = var.wgui_username
            wgui_password = var.wgui_password
            le_email_addr = var.le_email_addr
          })
          path        = "/root/docker-compose.yml"
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
          content = templatefile("${path.module}/templates/update-dynu.tpl", {
            dynu_credentials = var.dynu_credentials
            dynu_domain      = var.dynu_domain
          })
          path        = "/root/update_dynu.sh"
          permissions = "0700"
        },
        {
          content     = file("${path.module}/templates/docker-compose.service")
          path        = "/etc/systemd/system/docker-compose-app.service"
          permissions = "0644"
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
