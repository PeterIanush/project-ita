resource "google_compute_instance" "default" {
  name         = "${format("%s","${var.company}-${var.env}-${var.region_map["${var.var_region_name}"]}-instance1")}"
  machine_type  = "n1-standard-1"
  #zone         =   "${element(var.var_zones, count.index)}"
  zone          =   "${format("%s","${var.var_region_name}-b")}"
  tags          = ["ssh","http"]
  boot_disk {
    initialize_params {
      image     =  "centos-7-v20180129"     
    }
  }
labels {
      webserver =  "true"     
    }
metadata {
        startup-script = <<SCRIPT
        sudo add-apt-repository ppa:webupd8team/java
	sudo apt-get update -qy
	sudo apt-get install -qy oracle-java8-installer
	sudo apt-get install -qy oracle-java8-unlimited-jce-policy
	wget http://www.sonatype.org/downloads/nexus-latest-bundle.tar.gz
	cp nexus-latest-bundle.tar.gz /usr/local/
	cd /usr/local/
	tar -xvzf nexus-latest-bundle.tar.gz
	ln -s nexus-2.11.3-01 nexus
	adduser --disabled-password --disabled-login nexus
	chown -R nexus:nexus ./nexus-2.11.3-01/
	chown -R nexus:nexus ./sonatype-work/
	cp nexus/bin/nexus /etc/init.d/nexus
	chmod 755 /etc/init.d/nexus
	chown root /etc/init.d/nexus
	update-rc.d nexus defaults
        SCRIPT
    } 
network_interface {
    subnetwork = "${google_compute_subnetwork.public_subnet.name}"
    access_config {
      // Ephemeral IP
    }
  }
}
