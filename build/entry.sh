#!/bin/bash


groupadd -g `id -g` $USER
useradd -u `id -u` -g `id -g`  $USER
chown -Rvf $USER /root  

_help()
{
  echo ""
  echo "usage:"
  echo ""
  echo "   script  init|.."
  echo "   <other command> ..."
  echo "   "
  echo "examples:"
  echo ""
  echo "   script init"
  echo ""
  exit 0
}
if [ "$1" = "" ] ; then
  _help
fi

cd /workspace/$RPATH

if [ "$1" != "script" ] ; then
  exec $*
  exit $?
fi

if [ "$2" = "init" ] ; then
  echo ""
  echo "example for a script command "
  echo ""
  exit 0
fi
