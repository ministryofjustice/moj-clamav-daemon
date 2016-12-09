Provide a ClamAV daemon running in a docker container, listening for connections on port 3310

This project is based on;

* [ClamAV](https://www.clamav.net/) - Open source virus scanner

* [UKHomeOffice/docker-clamav](https://github.com/UKHomeOffice/docker-clamav) - Open source project by UK Home Office tying together all of the above

This is a component of the [mojfile-uploader](https://github.com/ministryofjustice/mojfile-uploader) project.

# Usage

    docker build -t clamav .

    docker run -d -p 3310:3310 --name clamd clamav

# Push to MoJ repository

Adjust version number, as appropriate

    docker tag clamav registry.service.dsd.io/ministryofjustice/clamav:0.1.0

    docker push registry.service.dsd.io/ministryofjustice/clamav:0.1.0



