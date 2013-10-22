describe("map_canvas", function () {

  console.log('raorao')
  beforeEach(function() {
    iPark = {}
    iPark.makeMap
  })

   it("should create google map and show San Francisco to user", function() {
    expect(iPark.map.mapOptions.zoom).toEqual(13)
    expect(iPark)
   });
    // $.each(markers, funsction(index, element) {
    //   iPark.zoomIn(marker);
    //   expect(iPark.map.zoom).toEqual(18)
    //   iPark.zoomOut(marker);
    //   expect(iPark.map.zoom).toEqual(13)
});



// iPark.makeMap()
// expect(mapOptions.center).toInclude?(37.78333, -122.4167)

// beforeEach() {
// iPark.makeMap()
// data = [{latitude: 37.7923883, longitude: -122.4100923, street: 1 Nob Hill, location_type: "garage", id: 3}]
// iPark.makeMarkers(data)
// iPark.makeMarker(this.latitude, this.longitude, this.street, this.location_type, this.id)

// }

// expect(iPark.marker.title).toEqual('Click to Zoom')
// expect(iPark.marker.position).toEqual(37.7923883, -122.4100923)



