/** @type {import {  } from "module";('next').NextConfig} */
const nextConfig = {
    images: {
        remotePatterns: [{
            protocol: "https",
            hostname: "image.tmdb.org",
        }, ],
    },
    eslint: {
        ignoreDuringBuilds: true,
    },
};

export default nextConfig;