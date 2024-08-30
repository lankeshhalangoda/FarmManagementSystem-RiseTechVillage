<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('crops', function (Blueprint $table) {
            $table->id();
            $table->string('name')->nullable();
            $table->string('growth_stage')->nullable();
            $table->date('planting_date')->nullable();
            $table->date('harvest_date')->nullable();
            $table->integer('cycle_progress')->nullable();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('crops');
    }
};
