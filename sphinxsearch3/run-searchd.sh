#!/bin/bash

searchd --config /etc/sphinx/sphinx.conf --nodetach "$@"
