#include <iostream>
#include <mpi.h>
#include <cmath>
#include <time.h>

double f(double x) {
    return 4.0 / (1.0 + x * x);
}

double sequential_integral(int N, double dx) {
    double sum = 0.0;
    for (int i = 0; i < N; i++) {
        sum += (f(i * dx) + 4 * f((i + 0.5) * dx) + f((i + 1) * dx)) * dx / 6;
    }
    return sum;
}

double parallel_integral(int N, int p, int rank, double dx) {
    int start = rank * (N / p);
    int end = (rank + 1) * (N / p);
    if (rank == p - 1) {
        end = N;
    }
    
    double part = 0.0;
    for (int i = start; i < end; i++) {
        part += (f(i * dx) + 4 * f((i + 0.5) * dx) + f((i + 1) * dx)) * dx / 6;
    }
    
    double sum = 0.0;
    MPI_Reduce(&part, &sum, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
    
    return sum;
}
int main(int argc, char** argv) {
    MPI_Init(&argc, &argv);
    int p, rank;
    MPI_Comm_size(MPI_COMM_WORLD, &p);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    int N = 1000000;
    double dx = 1.0 / N;
    MPI_Bcast(&dx, 1, MPI_DOUBLE, 0, MPI_COMM_WORLD);
    
    double I0;

    if (rank == 0) {
        double start_seq = MPI_Wtime();
        I0 = sequential_integral(N, dx);
        double end_seq = MPI_Wtime();
        std::cout << "I0: " << I0 << std::endl;
        std::cout << "Sequential time: " << end_seq - start_seq << " sec" << std::endl;
    }
    double start_par = MPI_Wtime();
    double I = parallel_integral(N, p, rank, dx);
    double end_par = MPI_Wtime();
    if (rank == 0) {
        std::cout << "I: " << I << std::endl;
        std::cout << "Parallel time: " << end_par - start_par << " sec" << std::endl;
        std::cout << "Relative error: " << std::abs(I - I0) / I0 << std::endl;    
    }
    MPI_Finalize();
    return 0;
}
