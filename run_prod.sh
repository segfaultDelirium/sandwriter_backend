#!/bin/bash

mix deps.get --only prod
MIX_ENV=prod mix compile
# MIX_ENV=prod mix assets.deploy
PORT=4000 MIX_ENV=prod mix phx.server
