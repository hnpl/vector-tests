CXX = riscv64-unknown-linux-gnu-g++
CXXFLAGS = -O3 -march=rv64gcv
FC = riscv64-unknown-linux-gnu-gfortran
FCFLAGS = -O3 -march=rv64gcv
OUTPUT_SUFFIX = .rvv

all: gather scatter stream vadd vector_sum verify_compilation

bin_dir:
	mkdir -p bin

gather: src/gather.cpp bin_dir
	$(CXX) $(CXXFLAGS) src/gather.cpp -o bin/gather$(OUTPUT_SUFFIX)

scatter: src/scatter.cpp bin_dir
	$(CXX) $(CXXFLAGS) src/scatter.cpp -o bin/scatter$(OUTPUT_SUFFIX)

stream: src/stream.cpp bin_dir
	$(CXX) $(CXXFLAGS) src/stream.cpp -o bin/stream$(OUTPUT_SUFFIX)

vadd: src/vadd.cpp bin_dir
	$(CXX) $(CXXFLAGS) src/vadd.cpp -o bin/vadd$(OUTPUT_SUFFIX)

vector_sum: src/vector_sum.f90 bin_dir
	$(FC) $(FCFLAGS) src/vector_sum.f90 -o bin/vector_sum$(OUTPUT_SUFFIX)

verify_compilation: all
	./verify_compilation.sh

clean:
	rm -rf *.o bin
