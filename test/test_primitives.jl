struct MyCurve end

@testset "Developer" begin
    # Implement interface
    GeoInterface.isgeometry(::MyCurve) = true
    GeoInterface.geomtype(::MyCurve) = GeoInterface.LineStringTrait()
    GeoInterface.ncoord(::GeoInterface.LineStringTrait, geom::MyCurve) = 2
    GeoInterface.ngeom(::GeoInterface.LineStringTrait, geom::MyCurve) = 2
    GeoInterface.getgeom(::GeoInterface.LineStringTrait, geom::MyCurve, i) = [[1, 2], [2, 3]][i]
    GeoInterface.convert(::Type{MyCurve}, ::GeoInterface.LineStringTrait, geom) = geom

    # Test validity
    geom = MyCurve()
    @test testgeometry(geom)

    @test !isnothing(GeoInterface.convert(MyCurve, geom))

    # Check functions
    @test GeoInterface.npoint(geom) == 2  # defaults to ngeom
    @test_throws MethodError GeoInterface.area(geom)

end
