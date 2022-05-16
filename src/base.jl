# Implementation of GeoInterface for Base Types

GeoInterface.isgeometry(::Type{<:AbstractVector{<:Real}}) = true
GeoInterface.geomtrait(::AbstractVector{<:Real}) = PointTrait()
GeoInterface.ncoord(::PointTrait, geom::AbstractVector{<:Real}) = Base.length(geom)
GeoInterface.getcoord(::PointTrait, geom::AbstractVector{<:Real}, i) = getindex(geom, i)

GeoInterface.isgeometry(::Type{<:NTuple{N,<:Real}}) where {N} = true
GeoInterface.geomtrait(::NTuple{N,<:Real}) where {N} = PointTrait()
GeoInterface.ncoord(::PointTrait, geom::NTuple{N,<:Real}) where {N} = N
GeoInterface.getcoord(::PointTrait, geom::NTuple{N,<:Real}, i) where {N} = getindex(geom, i)

for i in 2:4
    sig = NamedTuple{default_coord_names[1:i],NTuple{i,T}} where {T<:Real}
    GeoInterface.isgeometry(::Type{<:sig}) = true
    GeoInterface.geomtrait(::sig) = PointTrait()
    GeoInterface.ncoord(::PointTrait, geom::sig) = i
    GeoInterface.getcoord(::PointTrait, geom::sig, i) = getindex(geom, i)
end
