FROM odoo:19

USER root

# Install system dependencies, Thai fonts, and UTF-8 support
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3-pip \
    fonts-thai-tlwg \
    fonts-dejavu-core \
    fonts-liberation2 \
    locales && \
    locale-gen en_US.UTF-8 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Copy requirements file and install Python packages
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir --break-system-packages -r /tmp/requirements.txt

# Ensure correct permissions for Odoo directories
RUN mkdir -p /mnt/extra-addons && \
    chown -R odoo:odoo /mnt/extra-addons /var/lib/odoo /etc/odoo

USER odoo
