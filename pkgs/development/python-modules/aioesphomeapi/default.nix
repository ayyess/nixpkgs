{ lib
, aiohappyeyeballs
, async-timeout
, buildPythonPackage
, chacha20poly1305-reuseable
, cython_3
, fetchFromGitHub
, mock
, noiseprotocol
, protobuf
, pytest-asyncio
, pytestCheckHook
, pythonOlder
, setuptools
, zeroconf
}:

buildPythonPackage rec {
  pname = "aioesphomeapi";
  version = "21.0.0";
  pyproject = true;

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "esphome";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-KT38NY1BZM6Qr1EeC05vM9IcVKO7GaEx0102TUzkyRE=";
  };

  nativeBuildInputs = [
    setuptools
    cython_3
  ];

  propagatedBuildInputs = [
    aiohappyeyeballs
    chacha20poly1305-reuseable
    noiseprotocol
    protobuf
    zeroconf
  ] ++ lib.optionals (pythonOlder "3.11") [
    async-timeout
  ];

  nativeCheckInputs = [
    mock
    pytest-asyncio
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "aioesphomeapi"
  ];

  meta = with lib; {
    description = "Python Client for ESPHome native API";
    homepage = "https://github.com/esphome/aioesphomeapi";
    changelog = "https://github.com/esphome/aioesphomeapi/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ fab hexa ];
  };
}
