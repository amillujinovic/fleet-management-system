using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace projekatFlutter.Migrations
{
    /// <inheritdoc />
    public partial class CascadeDeleteVehicle : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Alerts_Vehicles_VehicleId",
                table: "Alerts");

            migrationBuilder.DropForeignKey(
                name: "FK_DeviceTrackers_Vehicles_VehicleId",
                table: "DeviceTrackers");

            migrationBuilder.DropForeignKey(
                name: "FK_VehicleGeofences_Geofences_GeofenceId",
                table: "VehicleGeofences");

            migrationBuilder.RenameColumn(
                name: "password",
                table: "Users",
                newName: "Password");

            migrationBuilder.RenameColumn(
                name: "email",
                table: "Users",
                newName: "Email");

            migrationBuilder.AddForeignKey(
                name: "FK_Alerts_Vehicles_VehicleId",
                table: "Alerts",
                column: "VehicleId",
                principalTable: "Vehicles",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_DeviceTrackers_Vehicles_VehicleId",
                table: "DeviceTrackers",
                column: "VehicleId",
                principalTable: "Vehicles",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_VehicleGeofences_Geofences_GeofenceId",
                table: "VehicleGeofences",
                column: "GeofenceId",
                principalTable: "Geofences",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Alerts_Vehicles_VehicleId",
                table: "Alerts");

            migrationBuilder.DropForeignKey(
                name: "FK_DeviceTrackers_Vehicles_VehicleId",
                table: "DeviceTrackers");

            migrationBuilder.DropForeignKey(
                name: "FK_VehicleGeofences_Geofences_GeofenceId",
                table: "VehicleGeofences");

            migrationBuilder.RenameColumn(
                name: "Password",
                table: "Users",
                newName: "password");

            migrationBuilder.RenameColumn(
                name: "Email",
                table: "Users",
                newName: "email");

            migrationBuilder.AddForeignKey(
                name: "FK_Alerts_Vehicles_VehicleId",
                table: "Alerts",
                column: "VehicleId",
                principalTable: "Vehicles",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_DeviceTrackers_Vehicles_VehicleId",
                table: "DeviceTrackers",
                column: "VehicleId",
                principalTable: "Vehicles",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_VehicleGeofences_Geofences_GeofenceId",
                table: "VehicleGeofences",
                column: "GeofenceId",
                principalTable: "Geofences",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
