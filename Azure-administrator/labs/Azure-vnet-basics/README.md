# Azure VNet Basics: Two Subnets and NSG Rules

## Overview

This lab provides a hands-on introduction to Azure Virtual Networks (VNets), the foundational building block for your private network in Azure. You will create a VNet, segment it into two subnets (frontend and backend), and then secure the backend subnet using a Network Security Group (NSG).

By the end of this lab, you will have a clear understanding of network segmentation and stateful firewalls in Azure, which are essential for designing secure and scalable cloud solutions.

## What You'll Learn

- How to create an Azure Virtual Network (VNet) with a custom address space.
- How to divide a VNet into multiple subnets.
- How to create and configure a Network Security Group (NSG).
- How to associate an NSG with a specific subnet.
- How to define inbound security rules to allow or deny traffic based on source, destination, and port.
- How to test your network security configuration using virtual machines.

## Prerequisites

- An active **Azure subscription** (a free trial works).
- **Azure CLI** installed and configured (`az login`). You can also use the Azure Cloud Shell from the portal.
- Basic familiarity with the command line.

## Architecture

