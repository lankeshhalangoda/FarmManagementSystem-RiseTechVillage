<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('growth_entries', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('crop_id')->nullable();
            $table->string('stage')->nullable();
            $table->text('note')->nullable();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('growth_entries');
    }
};
