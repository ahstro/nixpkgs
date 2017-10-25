{ lib
, buildPythonPackage
, fetchPypi
, pbr
, python_mimeparse
, extras
, lxml
, unittest2
, traceback2
, isPy3k
}:

buildPythonPackage rec {
  pname = "testtools";
  version = "2.3.0";
  name = "${pname}-${version}";

  # Python 2 only judging from SyntaxError
#   disabled = isPy3k;

  src = fetchPypi {
    inherit pname version;
    sha256 = "5827ec6cf8233e0f29f51025addd713ca010061204fdea77484a2934690a0559";
  };

  propagatedBuildInputs = [ pbr python_mimeparse extras lxml unittest2 ];
  buildInputs = [ traceback2 ];
  patches = [ ./testtools_support_unittest2.patch ];

  # No tests in archive
  doCheck = false;

  meta = {
    description = "A set of extensions to the Python standard library's unit testing framework";
    homepage = http://pypi.python.org/pypi/testtools;
    license = lib.licenses.mit;
  };
}