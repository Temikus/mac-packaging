###Functions###

mkdmg()
{

  if [[ $1 =~ .pkg$ ]]; then
    echo ".pkg file detected"
    mkdmg_from_pkg "$1"
  fi

  if [[ $1 =~ .app$ ]]; then
    echo ".app file detected"
    mkdmg_from_app "$1"
  else
  	echo "Could not detect filetype, exiting..."
  	exit 1
  fi

}

mkdmg_from_app()
{
  BASENAME=$(basename "$1" .app)

  echo "Creating packing environment..."
  mkdir "$BASENAME"
  mv "$1" "$BASENAME"

  echo "Creating DMG..."

  hdiutil create -volname "$BASENAME" -srcfolder "$BASENAME" -uid 99 -gid 99 -ov -format UDZO -imagekey zlib-level=9  "$BASENAME.dmg"

  echo "Creating manifest..."

  makepkginfo "$BASENAME.dmg" > "$BASENAME.plist"
}

mkdmg_from_pkg()
{
  BASENAME=$(basename "$1" .pkg)

  echo "Creating packing environment..."
  mkdir "$BASENAME"
  mv "$1" "$BASENAME"

  echo "Creating DMG..."

  hdiutil create -volname "$BASENAME" -srcfolder "$BASENAME" -uid 99 -gid 99 -ov -format UDZO -imagekey zlib-level=9  "$BASENAME.dmg"

  echo "Creating manifest..."

  makepkginfo "$BASENAME.dmg" > "$BASENAME.plist"
}

mkmanifest()
{
	makepkginfo "$1" > "$1.plist"
}

check_appleid()
{
  openssl asn1parse -inform der -in "$1/Contents/_MASReceipt/receipt" | grep -m 1 'OCTET STRING' | cut -d: -f4 | xxd -r -p > /tmp/app_payload.asn
  # shellcheck disable=2046
  printf "%d\n" 0x$(openssl asn1parse -inform der -in /tmp/app_payload.asn | grep -A 2 ':04$' | tail -1 | cut -d: -f4 | cut -c5-)
}
