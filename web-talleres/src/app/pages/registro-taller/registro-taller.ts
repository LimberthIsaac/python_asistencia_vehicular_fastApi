import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { CommonModule } from '@angular/common';
import { GoogleMap, MapMarker } from '@angular/google-maps';

@Component({
  selector: 'app-registro-taller',
  standalone: true,
  imports: [FormsModule, CommonModule, GoogleMap, MapMarker],
  templateUrl: './registro-taller.html',
  styleUrl: './registro-taller.css',
})
export class RegistroTaller {
  tallerData = {
    razon_social: '',
    nit: '',
    correo: '',
    password: '',
    ubicacion_base_latitud: null as number | null,
    ubicacion_base_longitud: null as number | null,
    horario_apertura: '00:00:00',
    horario_cierre: '23:59:59'
  };

  es247 = true;
  isLoading = false;
  errorMessage = '';

  // Configuración del Mapa
  mapOptions: google.maps.MapOptions = {
    disableDefaultUI: true,
    zoomControl: true,
    styles: [
      { "elementType": "geometry", "stylers": [{ "color": "#1C1C1E" }] },
      { "elementType": "labels.text.fill", "stylers": [{ "color": "#8E8E93" }] },
      { "featureType": "water", "elementType": "geometry", "stylers": [{ "color": "#000000" }] },
      { "featureType": "road", "elementType": "geometry", "stylers": [{ "color": "#2C2C2E" }] },
      { "featureType": "poi", "stylers": [{ "visibility": "off" }] }
    ]
  };
  center: google.maps.LatLngLiteral = { lat: 0, lng: 0 };
  zoom = 15;
  markerPosition: google.maps.LatLngLiteral | null = null;

  constructor(private router: Router, private apiService: ApiService) {}

  toggle247() {
    if (this.es247) {
      this.tallerData.horario_apertura = '00:00:00';
      this.tallerData.horario_cierre = '23:59:59';
    } else {
      this.tallerData.horario_apertura = '08:00:00';
      this.tallerData.horario_cierre = '18:00:00';
    }
  }

  getCurrentLocation() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          const pos = {
            lat: position.coords.latitude,
            lng: position.coords.longitude
          };
          this.tallerData.ubicacion_base_latitud = pos.lat;
          this.tallerData.ubicacion_base_longitud = pos.lng;
          this.center = pos;
          this.markerPosition = pos;
          this.zoom = 17;
        },
        (error) => {
          console.error('Error obteniendo ubicación', error);
          alert('No se pudo obtener la ubicación. Por favor, asegúrate de dar permisos al navegador.');
        }
      );
    } else {
      alert('La geolocalización no está soportada por este navegador.');
    }
  }

  onMapClick(event: google.maps.MapMouseEvent) {
    if (event.latLng) {
      const pos = event.latLng.toJSON();
      this.tallerData.ubicacion_base_latitud = pos.lat;
      this.tallerData.ubicacion_base_longitud = pos.lng;
      this.markerPosition = pos;
    }
  }

  onSubmit() {
    this.isLoading = true;
    this.errorMessage = '';
    
    // Asegurar formato de tiempo si se editó manualmente (remover segundos si el input time no los tiene)
    if (this.tallerData.horario_apertura.length === 5) this.tallerData.horario_apertura += ':00';
    if (this.tallerData.horario_cierre.length === 5) this.tallerData.horario_cierre += ':00';

    console.log('Registrando taller...', this.tallerData);
    
    this.apiService.registerTaller(this.tallerData).subscribe({
      next: (response) => {
        console.log('Registro exitoso', response);
        this.isLoading = false;
        this.router.navigate(['/dashboard']);
      },
      error: (err) => {
        console.error('Error en registro', err);
        this.errorMessage = 'Hubo un error al registrar el taller. Por favor intente de nuevo.';
        this.isLoading = false;
      }
    });
  }
}
