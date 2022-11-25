import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    console.log('toto')
  }

  closePopup(marker) {
    const p = marker.getPopup()
    if (p.isOpen())
      marker.togglePopup()
  }

  openPopup(marker) {
    const p = marker.getPopup()
    if (!p.isOpen())
      marker.togglePopup()
  }

  popup(event) {
    const marker = this.markers.find((m) => m.id === event.detail)
    this.markers.forEach(m => this.closePopup(m))
    this.openPopup(marker)
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    this.#addMarkersToMap()
    this.#fitMapToMarkers()

    window.aaa = this

    console.log('JE SUIS A LA FIN DE CONNECT map controller')
    console.log(this.markers)
  }



  #addMarkersToMap() {
    this.markers = []
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      const m = new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
      m.id = marker.id
      this.markers.push(m)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

}
