<?php

use Illuminate\Support\Facades\Broadcast;

Broadcast::channel('belal-channel', function ($user) {
    return true; // يمكنك تخصيص التحقق هنا بناءً على متطلباتك
});
