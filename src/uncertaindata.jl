
import UncertainData: resample, UncertainDataset, UncertainIndexDataset, UncertainValueDataset, UncertainIndexValueDataset

##################################################
# Basic resampling for `UncertainDataset`s
##################################################
UT = Union{UncertainValueDataset, UncertainIndexDataset, UncertainDataset}

s_measure(s::UT, t::UT, args...; kwargs...) =
    s_measure(resample(s), resample(t), args...; kwargs...)

jdd(s::UT, t::UT, m::Int, args...; kwargs...) =
    jdd(resample(s), resample(t), args...; kwargs...)

mutualinfo(s::UT, t::UT, args...; kwargs...) =
    mutualinfo(resample(s), resample(t), args...; kwargs...)

transferentropy(s::UT, t::UT, args...; kwargs...) =
    transferentropy(resample(s), resample(t), args...; kwargs...)

transferentropy(s::UT, t::UT, c::UT, args...; kwargs...) =
    transferentropy(resample(s), resample(t), resample(c), args...; kwargs...)

predictive_asymmetry(s::UT, t::UT, args...; kwargs...) =
    predictive_asymmetry(resample(s), resample(t), args...; kwargs...)

predictive_asymmetry(s::UT, t::UT, c::UT, args...; kwargs...) =
    predictive_asymmetry(resample(s), resample(t), resample(c), args...; kwargs...)

crossmap(s::UT, t::UT, args...; kwargs...) = 
    crossmap(resample(s), resample(t), args...; kwargs...)

ccm(s::UT, t::UT, args...; kwargs...) = 
    ccm(resample(s), resample(t), args...; kwargs...)

##########################################################################
# Basic resampling for `UncertainIndexValueDataset` (no constraints)
##########################################################################
const UIVD = UncertainIndexValueDataset

# TODO: warn about potential index reversals?
#
# function warn_about_sampling(s::V, t::W) 
#     if s isa UIVD
#         @warn "`s` isa UncertainIndexValueDataset. Index reversals may occur. Consider constrained resampling."
#     end

#     if t isa UIVD
#         @warn "`t` isa UncertainIndexValueDataset. Index reversals may occur. Consider constrained resampling."
#     end
# end

# function warn_about_sampling(s::V, t::W, c::X)
#     warn_about_sampling(s, t)
#     if c isa UIVD
#         @warn "`c` isa UncertainIndexValueDataset. Index reversals may occur. Consider constrained resampling."
#     end
# end

s_measure(s::UIVD, t::UIVD, args...; kwargs...) =
    s_measure(resample(s.values), resample(t.values), args...; kwargs...)

jdd(s::UIVD, t::UIVD, args...; kwargs...) =
    jdd(resample(s.values), resample(t.values), args...; kwargs...)

mutualinfo(s::UIVD, t::UIVD, args...; kwargs...) =
    mutualinfo(resample(s.values), resample(t.values), args...; kwargs...)

transferentropy(s::UIVD, t::UIVD, args...; kwargs...) =
    transferentropy(resample(s.values), resample(t.values), args...; kwargs...)

transferentropy(s::UIVD, t::UIVD, c::UIVD, args...; kwargs...) =
    transferentropy(resample(s.values), resample(t.values), resample(c.values), args...; kwargs...)

predictive_asymmetry(s::UIVD, t::UIVD, args...; kwargs...) =
    predictive_asymmetry(resample(s.values), resample(t.values), args...; kwargs...)

predictive_asymmetry(s::UIVD, t::UIVD, c::UIVD, args...; kwargs...) =
    predictive_asymmetry(resample(s.values), resample(t.values), resample(c.values), args...; kwargs...)

crossmap(s::UIVD, t::UIVD, args...; kwargs...) = 
    crossmap(resample(s.values), resample(t.values), args...; kwargs...)

ccm(s::UIVD, t::UIVD, args...; kwargs...) = 
    ccm(resample(s.values), resample(t.values), args...; kwargs...)
