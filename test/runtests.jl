using Reactant, SafeTestsets, Test

if lowercase(get(ENV, "REACTANT_BACKEND_GROUP", "all")) == "gpu"
    Reactant.set_default_backend("gpu")
end

const REACTANT_TEST_GROUP = lowercase(get(ENV, "REACTANT_TEST_GROUP", "all"))

@testset "Reactant.jl Tests" begin
    if REACTANT_TEST_GROUP == "all" || REACTANT_TEST_GROUP == "core"
        if Sys.isapple() && haskey(Reactant.XLA.global_backend_state.clients, "metal")
            @safetestset "Metal Plugin" include("plugins/metal.jl")
        end

        println("\n", " --------- Layout")
        @safetestset "Layout" include("layout.jl")
        println("\n", " --------- Tracing")
        @safetestset "Tracing" include("tracing.jl")
        println("\n", " --------- Basic")
        @safetestset "Basic" include("basic.jl")
        println("\n", " --------- Constructor")
        @safetestset "Constructor" include("constructor.jl")
        println("\n", " --------- Autodiff")
        @safetestset "Autodiff" include("autodiff.jl")
        println("\n", " --------- Complex")
        @safetestset "Complex" include("complex.jl")
        println("\n", " --------- Broadcast")
        @safetestset "Broadcast" include("bcast.jl")
        println("\n", " --------- Struct")
        @safetestset "Struct" include("struct.jl")
        println("\n", " --------- Closure")
        @safetestset "Closure" include("closure.jl")
        println("\n", " --------- Compile")
        @safetestset "Compile" include("compile.jl")
        println("\n", " --------- IR")
        @safetestset "IR" include("ir.jl")
        println("\n", " --------- Buffer Donation")
        @safetestset "Buffer Donation" include("buffer_donation.jl")
        println("\n", " --------- Shortcuts")
        @safetestset "Shortcuts to MLIR ops" include("ops.jl")
        println("\n", " --------- Wrapped")
        @safetestset "Wrapped Arrays" include("wrapped_arrays.jl")
        println("\n", " --------- Control Flow")
        @safetestset "Control Flow" include("control_flow.jl")
        println("\n", " --------- Sorting")
        @safetestset "Sorting" include("sorting.jl")
        println("\n", " --------- Indexing")
        @safetestset "Indexing" include("indexing.jl")
        println("\n", " --------- Custom Num")
        if !Sys.isapple()
            @safetestset "Custom Number Types" include("custom_number_types.jl")
        end
        println("\n", " --------- Sharding")
        @safetestset "Sharding" include("sharding.jl")
        println("\n", " --------- Comm Opt")
        @safetestset "Comm Optimization" include("optimize_comm.jl")
        println("\n", " --------- Cluster Detection")
        @safetestset "Cluster Detection" include("cluster_detector.jl")
        println("\n", " --------- Config")
        @safetestset "Config" include("config.jl")
        println("\n", " --------- Batching")
        @safetestset "Batching" include("batching.jl")
    end

    if REACTANT_TEST_GROUP == "all" || REACTANT_TEST_GROUP == "integration"
        println("\n", " --------- Cuda")
        @safetestset "CUDA" include("integration/cuda.jl")
        println("\n", " --------- KernelAbstractions")
        @safetestset "KernelAbstractions" include("integration/kernelabstractions.jl")
        println("\n", " --------- LinearAlgebra")
        @safetestset "Linear Algebra" include("integration/linear_algebra.jl")
        println("\n", " --------- OffsetArrays")
        @safetestset "OffsetArrays" include("integration/offsetarrays.jl")
        println("\n", " --------- OneHotArrays")
        @safetestset "OneHotArrays" include("integration/onehotarrays.jl")
        println("\n", " --------- AbstractFFTs")
        @safetestset "AbstractFFTs" include("integration/fft.jl")
        println("\n", " --------- SpecialFunctions")
        @safetestset "SpecialFunctions" include("integration/special_functions.jl")
        println("\n", " --------- Random")
        @safetestset "Random" include("integration/random.jl")
        println("\n", " --------- Python")
        @safetestset "Python" include("integration/python.jl")
        println("\n", " --------- Optimisers")
        @safetestset "Optimisers" include("integration/optimisers.jl")
    end

    if REACTANT_TEST_GROUP == "all" || REACTANT_TEST_GROUP == "neural_networks"
        println("\n", " --------- NNlib")
        @safetestset "NNlib Primitives" include("nn/nnlib.jl")
        println("\n", " --------- Flux.jl")
        @safetestset "Flux.jl Integration" include("nn/flux.jl")
        if Sys.islinux()
            @safetestset "LuxLib Primitives" include("nn/luxlib.jl")
            @safetestset "Lux Integration" include("nn/lux.jl")
        end
    end
end
