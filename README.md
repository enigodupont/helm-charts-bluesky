# NOT MAINTAINED 25.04.2026

I have decommissioned by Kubernetes homelab a while ago. I also won't maintain this repository anymore and am archiving it.

# Nerkho's Helm Charts

This repository contains Helm charts.

# Usage

Add the repository

```bash
helm repo add nerkho https://charts.nerkho.ch
helm repo update
```

Then run `helm search repo nerkho` to see the available charts.

## Release Process

Package the helm chart

```bash
helm package charts/bluesky-pds
```

Push the helm chart

```bash
helm push PATH_TO_CHART/CHART.tgz oci://registry-1.docker.io/DOCKER_USER_NAME
```