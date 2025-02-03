{ lib,
  stdenvNoCC,
  fetchFromGitHub,
  gitUpdater,
  gtk3,

  colorVariants ? [ "all" ],
}:

lib.checkListOfEnum "Flatery colors"
  [
    "none"
    "all"
    "Black-Dark" "Black"
    "Blue-Dark" "Blue"
    "Gray-Dark" "Gray"
    "Green-Dark" "Green"
    "Indigo-Dark" "Indigo"
    "Mint-Dark" "Mint"
    "Orange-Dark" "Orange"
    "Pink-Dark" "Pink"
    "Red-Dark" "Red"
    "Sky-Dark" "Sky"
    "Teal-Dark" "Teal"
    "Yellow-Dark" "Yellow"
  ]
  colorVariants
stdenvNoCC.mkDerivation {
  pname = "flatery-icon-theme";
  version = "master";

  src = fetchFromGitHub {
    owner = "cbrnix";
    repo = "Flatery";
    rev = "30bef81ba98ac4c4f764e9fc1b705a86e0d27e2c";
    hash = "sha256-qt5z6xMUsMUWUDK1dosrFGNy/dRpneLduk3KCPYBZW8=";
  };

  nativeBuildInputs = [
    gtk3
  ];

  dontDropIconThemeCache = true;
  dontRewriteSymlinks = true;

  postPatch = ''
    patchShebangs install.sh
  '';

  installPhase = ''
    runHook preInstall

    # Replace output directory in the install script
    substituteInPlace install.sh \
      --replace-fail '/usr/share/icons' '$out/share/icons'
    # Create new directory for the output
    mkdir -p $out/share/icons

    # Copy base themes to output for the symlinks to work
    cp -rf Flatery $out/share/icons
    cp -rf Flatery-Dark $out/share/icons

    # Install selected themes
    ./install.sh -g -v '${builtins.toString colorVariants}'

    for theme in $out/share/icons/*; do
      gtk-update-icon-cache --force $theme
    done

    runHook postInstall
  '';

  passthru.updateScript = gitUpdater {};
}
