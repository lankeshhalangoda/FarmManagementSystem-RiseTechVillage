<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSoilConditionsTable extends Migration
{
    public function up()
    {
        Schema::create('soil_conditions', function (Blueprint $table) {
            $table->id();
            $table->string('location');
            $table->float('temperature');
            $table->float('moisture');
            $table->float('ph_level');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('soil_conditions');
    }
};
