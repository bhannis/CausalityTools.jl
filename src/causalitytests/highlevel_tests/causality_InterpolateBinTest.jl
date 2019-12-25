import UncertainData

# Performs the causality test for a single ensemble member
function apply_test(source, target, test::CausalityTest, intp_and_bin::UncertainData.InterpolateAndBin)
    s_vals = resample(source, intp_and_bin)
    t_vals = resample(target, intp_and_bin)
    
    causality(s_vals, t_vals, test)
end

"""
    causality(source::AbstractUncertainIndexValueDataset, 
        target::AbstractUncertainIndexValueDataset, 
        test::InterpolatedBinTest{CT, IB}) where {CT, IB}

Apply a causality test of type `CT` to `test.n` independent 
realisations of `source` and `target`. Each realisation is
generated by first drawing realisations of the datasets, 
then using the provided `InterpolateAndBin` resampling scheme to 
interpolate and bin the draw.

See also [`UncertainData.InterpolateAndBin`](@ref).

## Examples 

```
# Some test data
N = 100
sys = ar1_unidir(c_xy = 0.2)
X, Y = example_uncertain_indexvalue_datasets(sys, N, (1, 2),
    d_xval = Uniform(0.001, 0.2), d_yval = Uniform(0.001, 0.2));

# Define a causality test 
k, l, m = 1, 1, 1 # embedding parameters
n_subdivisions = floor(Int, N^(1/(k + l + m + 1)))
state_space_binning = RectangularBinning(n_subdivisions)

te_test = VisitationFrequencyTest(k = k, l = l, m = m,
            binning = state_space_binning, 
            ηs = ηs, b = 2) # use base-2 logarithms
pa_test = PredictiveAsymmetryTest(predictive_test = te_test)


# Define interpolation grid over the range of available index values
tmin = max(minimum(mean.(X.indices)), minimum(mean.(Y.indices)))
tmax = max(maximum(mean.(X.indices)), maximum(mean.(Y.indices)))
intp_grid = tmin:0.01:tmax

# Define binning grid
left_bin_edges = tmin:1.5:tmax

# Define the InterpolateAndBin instance
intp_bin = InterpolateAndBin(mean, left_bin_edges, Linear(), intp_grid, Flat(OnGrid()))

# Define interpolate-and-bin test
ib_test = InterpolateBinTest(pa_test, intp_bin, 2)
```
"""
function causality(source::AbstractUncertainIndexValueDataset, 
    target::AbstractUncertainIndexValueDataset, 
    test::InterpolateBinTest{CT, IB}) where {CT, IB}
    
    resamp = test.interpolate_bin_resampling
    
    [apply_test(source, target, test.test, resamp) for i = 1:test.n]
end