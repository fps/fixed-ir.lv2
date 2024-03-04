FFTCONVOLVER_SOURCES = vendored/FFTConvolver/AudioFFT.cpp vendored/FFTConvolver/Utilities.cpp vendored/FFTConvolver/FFTConvolver.cpp


plugin.so: plugin.cc
	g++ -shared -fPIC plugin.cc ${FFTCONVOLVER_SOURCES}
