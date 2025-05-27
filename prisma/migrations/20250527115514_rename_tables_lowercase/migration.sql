/*
  Warnings:

  - You are about to drop the `Booking` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `District` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Division` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Location` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Payment` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Role` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Sports` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Turf` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `TurfPricing` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `TurfSports` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `TurfStaff` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Booking" DROP CONSTRAINT "Booking_customer_id_fkey";

-- DropForeignKey
ALTER TABLE "Booking" DROP CONSTRAINT "Booking_turf_id_fkey";

-- DropForeignKey
ALTER TABLE "District" DROP CONSTRAINT "District_division_id_fkey";

-- DropForeignKey
ALTER TABLE "Location" DROP CONSTRAINT "Location_district_id_fkey";

-- DropForeignKey
ALTER TABLE "Payment" DROP CONSTRAINT "Payment_booking_id_fkey";

-- DropForeignKey
ALTER TABLE "Turf" DROP CONSTRAINT "Turf_owner_id_fkey";

-- DropForeignKey
ALTER TABLE "TurfPricing" DROP CONSTRAINT "TurfPricing_turf_id_fkey";

-- DropForeignKey
ALTER TABLE "TurfSports" DROP CONSTRAINT "TurfSports_sport_id_fkey";

-- DropForeignKey
ALTER TABLE "TurfSports" DROP CONSTRAINT "TurfSports_turf_id_fkey";

-- DropForeignKey
ALTER TABLE "TurfStaff" DROP CONSTRAINT "TurfStaff_turf_id_fkey";

-- DropForeignKey
ALTER TABLE "TurfStaff" DROP CONSTRAINT "TurfStaff_user_id_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_role_id_fkey";

-- DropTable
DROP TABLE "Booking";

-- DropTable
DROP TABLE "District";

-- DropTable
DROP TABLE "Division";

-- DropTable
DROP TABLE "Location";

-- DropTable
DROP TABLE "Payment";

-- DropTable
DROP TABLE "Role";

-- DropTable
DROP TABLE "Sports";

-- DropTable
DROP TABLE "Turf";

-- DropTable
DROP TABLE "TurfPricing";

-- DropTable
DROP TABLE "TurfSports";

-- DropTable
DROP TABLE "TurfStaff";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "divisions" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "bn_name" TEXT NOT NULL,

    CONSTRAINT "divisions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "districts" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "bn_name" TEXT NOT NULL,
    "division_id" INTEGER NOT NULL,

    CONSTRAINT "districts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "locations" (
    "id" SERIAL NOT NULL,
    "district_id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "bn_name" TEXT NOT NULL,

    CONSTRAINT "locations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "role_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("role_id")
);

-- CreateTable
CREATE TABLE "users" (
    "user_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "email" TEXT,
    "password" TEXT NOT NULL,
    "role_id" INTEGER NOT NULL,
    "bkash_number" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "turfs" (
    "turf_id" SERIAL NOT NULL,
    "owner_id" INTEGER NOT NULL,
    "location_name" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "address_details" TEXT NOT NULL,
    "advance_amount" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "turfs_pkey" PRIMARY KEY ("turf_id")
);

-- CreateTable
CREATE TABLE "turfstaff" (
    "id" SERIAL NOT NULL,
    "turf_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "turfstaff_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sports" (
    "sport_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "sports_pkey" PRIMARY KEY ("sport_id")
);

-- CreateTable
CREATE TABLE "turfsports" (
    "id" SERIAL NOT NULL,
    "turf_id" INTEGER NOT NULL,
    "sport_id" INTEGER NOT NULL,

    CONSTRAINT "turfsports_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "turfpricing" (
    "id" SERIAL NOT NULL,
    "turf_id" INTEGER NOT NULL,
    "price_starts_at" TEXT NOT NULL,
    "price_ends_at" TEXT NOT NULL,
    "price" INTEGER NOT NULL,

    CONSTRAINT "turfpricing_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bookings" (
    "booking_id" SERIAL NOT NULL,
    "customer_id" INTEGER NOT NULL,
    "turf_id" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "starts_at" TEXT NOT NULL,
    "ends_at" TEXT NOT NULL,
    "booking_status" TEXT NOT NULL,
    "cancellation_reason" TEXT,
    "cancellation_time" TIMESTAMP(3),
    "payment_status" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "bookings_pkey" PRIMARY KEY ("booking_id")
);

-- CreateTable
CREATE TABLE "payments" (
    "payment_id" SERIAL NOT NULL,
    "booking_id" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL,
    "commission_amount" INTEGER NOT NULL,
    "owner_amount" INTEGER NOT NULL,
    "sender_bkash_number" TEXT NOT NULL,
    "recipient_bkash_number" TEXT NOT NULL,
    "transaction_id" TEXT NOT NULL,
    "payment_status" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "payments_pkey" PRIMARY KEY ("payment_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_phone_number_key" ON "users"("phone_number");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "payments_booking_id_key" ON "payments"("booking_id");

-- AddForeignKey
ALTER TABLE "districts" ADD CONSTRAINT "districts_division_id_fkey" FOREIGN KEY ("division_id") REFERENCES "divisions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "locations" ADD CONSTRAINT "locations_district_id_fkey" FOREIGN KEY ("district_id") REFERENCES "districts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "roles"("role_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "turfs" ADD CONSTRAINT "turfs_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "turfstaff" ADD CONSTRAINT "turfstaff_turf_id_fkey" FOREIGN KEY ("turf_id") REFERENCES "turfs"("turf_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "turfstaff" ADD CONSTRAINT "turfstaff_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "turfsports" ADD CONSTRAINT "turfsports_turf_id_fkey" FOREIGN KEY ("turf_id") REFERENCES "turfs"("turf_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "turfsports" ADD CONSTRAINT "turfsports_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "sports"("sport_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "turfpricing" ADD CONSTRAINT "turfpricing_turf_id_fkey" FOREIGN KEY ("turf_id") REFERENCES "turfs"("turf_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bookings" ADD CONSTRAINT "bookings_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bookings" ADD CONSTRAINT "bookings_turf_id_fkey" FOREIGN KEY ("turf_id") REFERENCES "turfs"("turf_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_booking_id_fkey" FOREIGN KEY ("booking_id") REFERENCES "bookings"("booking_id") ON DELETE RESTRICT ON UPDATE CASCADE;
