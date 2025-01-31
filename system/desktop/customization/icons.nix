{ lib,
  stdenvNoCC,
  fetchFromGitHub,
  gitUpdater,
  gtk3,
  breeze-icons,

  colorVariants ? [ "all" ],
}:

lib.checkListOfEnum "Flatery colors"
  [
    "none"
    "all"
    "Black-Dark" "Black"
    "Blue-Dark" "Blue"
    "Dark"
    "Gray-Dark" "Gray"
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

  propagatedBuildInputs = [
    breeze-icons
  ];

  dontDropIconThemeCache = true;

  dontPatchElf = true;
  dontRewriteSymlinks = true;

  postPatch = ''
    patchShebangs install.sh
  '';

  installPhase = ''
    runHook preInstall

    substituteInPlace install.sh \
      --replace-quiet '/usr/share/icons' '$out/share/icons'
    mkdir -p $out/share/icons

    ./install.sh -g -v '${builtins.toString colorVariants}'

    for theme in $out/share/icons/*; do
      gtk-update-icon-cache --force $theme
    done

    runHook postInstall
  '';

  passthru.updateScript = gitUpdater {};
}
